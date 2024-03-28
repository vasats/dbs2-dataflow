package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.ZaznamOSpotrebe;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ZaznamOSpotrebeRepository extends CrudRepository<ZaznamOSpotrebe,Integer> {
    List<ZaznamOSpotrebe> findAllByZarizeniHala(Hala hala);
}
