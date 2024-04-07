package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.Tovarna;
import cz.uhk.fim.dbs2dataflow.repository.HalaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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
    public Integer getAmountByTovarna(Tovarna tovarna){
        List<Hala> halas = repository.findAllByTovarna(tovarna);
        return halas.size();
    }
    public List<Hala> getByTovarnaId(Integer id){
        List<Hala> halas = repository.findAllByTovarnaId(id);
        return halas;
    }
}
