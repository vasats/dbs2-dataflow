package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Zarizeni;
import cz.uhk.fim.dbs2dataflow.repository.ZarizeniRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZarizeniService {
    ZarizeniRepository repository;
    @Autowired
    public ZarizeniService(ZarizeniRepository repository) {
        this.repository = repository;
    }

    public void addZarizeni(Zarizeni zarizeni){
        if (zarizeni.getNazev().trim().isBlank() || zarizeni.getOznaceni().trim().isBlank())
            throw new IllegalArgumentException();
        repository.save(zarizeni);
    }
    public List<Zarizeni> getByHalaID(Integer id){
        return repository.getZarizenisByHala_HalaID(id);
    }
}
