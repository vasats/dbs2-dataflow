package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.model.Zamestnanec;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ZamestnanecRepository extends CrudRepository<Zamestnanec,Integer> {
    Zamestnanec findZamestnanecByWebovyUcet(WebovyUcet ucet);
    Zamestnanec findZamestnanecById(int id);

}
