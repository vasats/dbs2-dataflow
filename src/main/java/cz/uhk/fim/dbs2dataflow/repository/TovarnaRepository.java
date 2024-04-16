package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Tovarna;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TovarnaRepository extends CrudRepository<Tovarna,Integer> {
    @Query(nativeQuery = true, value = "use energie select dbo.CelkovaCenaSpotreby(Tovarna.TovarnaID) from Tovarna where TovarnaID=:id ")
    float celkovaSpotreba(@Param("id") int id);

}
