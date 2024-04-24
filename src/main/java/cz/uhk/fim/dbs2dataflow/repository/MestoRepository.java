package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Mesto;
import org.springframework.data.repository.CrudRepository;

public interface MestoRepository extends CrudRepository<Mesto,String> {

}
