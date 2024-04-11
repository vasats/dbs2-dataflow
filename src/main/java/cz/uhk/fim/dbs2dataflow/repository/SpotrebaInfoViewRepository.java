package cz.uhk.fim.dbs2dataflow.repository;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.SpotrebaInfo;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface SpotrebaInfoViewRepository extends CrudRepository<SpotrebaInfo, Integer> {
    List<SpotrebaInfo> findAllByHala_HalaID(Integer id);
}
