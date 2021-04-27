package jwt;

import dao.UsuarioJpaController;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import static javax.crypto.Cipher.SECRET_KEY;

import javax.json.Json;
import javax.json.JsonObject;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.xml.bind.DatatypeConverter;
import objetosNegocio.Usuario;

@Path("auth")
public class InicioSesionJWT {

    EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
    UsuarioJpaController usuarioDAO = new UsuarioJpaController(factory);

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    public String validar(Usuario usuario) throws UnsupportedEncodingException {

        if (usuario != null) {
            long tiempo = System.currentTimeMillis();
            String jwt = Jwts.builder()
                    .setSubject("SistemasUniversidades")
                    .setId(usuario.getId() + "")
                    .setIssuedAt(new Date(tiempo))
                    .setExpiration(new Date(tiempo + 900000))
                    .claim("nombre", usuario.getNombre())
                    .claim("apellido", usuario.getApellido())
                    .claim("scope", "admin")
                    .signWith(SignatureAlgorithm.HS256, "secret".getBytes("UTF-8"))
                    .compact();
            System.out.println("-------------------->  " + jwt);

            Jws<Claims> claims = Jwts.parser()
                    .setSigningKey("secret".getBytes("UTF-8"))
                    .parseClaimsJws(jwt);
            System.out.println("------------>" + claims);
//                JsonObject json = Json.createObjectBuilder().add("JWT", jwt).build();                        
//                Response respuesta = Response.status(Response.Status.CREATED).entity(json).build();
            return jwt;
        }
        return null;
    }

}
