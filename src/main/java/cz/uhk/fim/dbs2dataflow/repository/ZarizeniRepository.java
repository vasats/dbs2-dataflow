package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.Zarizeni;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ZarizeniRepository extends CrudRepository<Zarizeni, Integer> {
    List<Zarizeni> getZarizenisByHala_HalaID(Integer halaID);

}
