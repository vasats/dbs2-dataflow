package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Zarizeni;
import cz.uhk.fim.dbs2dataflow.repository.ZarizeniRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZarizeniService {
    @Autowired
    ZarizeniRepository repository;

    public void addZarizeni(Zarizeni zarizeni){
        repository.save(zarizeni);
    }
    public List<Zarizeni> getByHalaID(Integer id){
        return repository.getZarizenisByHala_HalaID(id);
    }
}
