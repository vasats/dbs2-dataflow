package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.model.Zamestnanec;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ZamestnanecRepository extends CrudRepository<Zamestnanec,Integer> {
    Zamestnanec findZamestnanecByWebovyUcet(WebovyUcet ucet);
    Zamestnanec findZamestnanecById(int id);

    @Query(nativeQuery = true,value = "EXECUTE insertZamestnanecAdresa @jmeno = :jmeno, @prijmeni = :prijmeni" +
            ", @rodneCislo = :rodneCislo, @telefon = :telefon, @email = :email, @psc = :psc, " +
            "@ulice = :ulice, @cisloPopisne = :cisloPopisne")
    Zamestnanec insertZamestnanecAdresa(@Param("jmeno") String jmeno, @Param("prijmeni") String prijmeni,
                                 @Param("rodneCislo") String rodneCislo,
                                 @Param("telefon") String telefon, @Param("email") String email,
                                 @Param("psc") String psc,
                                 @Param("ulice") String ulice, @Param("cisloPopisne") String cisloPopisne);

}
