package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Mesto;
import cz.uhk.fim.dbs2dataflow.repository.MestoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MestoService {
    @Autowired
    MestoRepository repository;
    public Mesto getByPsc(String psc){
        Optional<Mesto> mesto = repository.findById(psc);
        return mesto.orElse(null);
    }
}
