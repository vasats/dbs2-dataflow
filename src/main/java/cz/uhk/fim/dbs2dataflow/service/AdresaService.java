package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Adresa;
import cz.uhk.fim.dbs2dataflow.repository.AdresaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdresaService {
    @Autowired
    AdresaRepository repository;

    public void save(Adresa adresa){
        repository.save(adresa);
    }
}
