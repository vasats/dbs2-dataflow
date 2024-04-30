package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.SpotrebaInfo;
import cz.uhk.fim.dbs2dataflow.repository.SpotrebaInfoViewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SpotrebaInfoViewService {

    SpotrebaInfoViewRepository repository;
    @Autowired
    public SpotrebaInfoViewService(SpotrebaInfoViewRepository repository) {
        this.repository = repository;
    }

    public List<SpotrebaInfo> getByHalaId(Integer id){
        return repository.findAllByHala_HalaID(id);
    }


}
