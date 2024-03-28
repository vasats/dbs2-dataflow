package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.exception.DataNotFoundException;
import cz.uhk.fim.dbs2dataflow.model.Tovarna;
import cz.uhk.fim.dbs2dataflow.repository.TovarnaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TovarnaService {
    @Autowired
    TovarnaRepository repository;
    public Tovarna getTovarnaById(Integer id){
        Optional<Tovarna> optional = repository.findById(id);
        if (optional.isPresent()){
            return optional.get();
        }
        throw new RuntimeException("tovarna nebyla nalezena");
    }

    public List<Tovarna> getAll(){
        List<Tovarna> tovarnaList = (List<Tovarna>) repository.findAll();
        if (tovarnaList.isEmpty()){
            throw new DataNotFoundException("zadna tovarna nenalezena");
        }
        return tovarnaList;
    }
}
