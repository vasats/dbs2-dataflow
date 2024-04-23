package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.ZaznamOPouziti;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ZaznamOPouzitiRepository extends CrudRepository<ZaznamOPouziti, Integer> {

}
