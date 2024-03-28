package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.repository.HalaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class HalaService {
    @Autowired
    HalaRepository repository;

    public Hala getByID(int halaID){
        Optional<Hala> optional = repository.findById(halaID);
        if (optional.isPresent())
            return optional.get();
        throw new DataNotFoundException("Hala nenalezena");
    }
}