package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.Tovarna;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface HalaRepository extends CrudRepository<Hala, Integer> {
    List<Hala> findAllByTovarna(Tovarna tovarna);
}
