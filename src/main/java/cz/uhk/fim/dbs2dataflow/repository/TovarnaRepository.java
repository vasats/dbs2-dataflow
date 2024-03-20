package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Tovarna;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TovarnaRepository extends CrudRepository<Tovarna,Integer> {

}
