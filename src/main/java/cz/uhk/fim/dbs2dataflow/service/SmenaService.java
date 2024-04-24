package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Smena;
import cz.uhk.fim.dbs2dataflow.repository.SmenaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SmenaService {
    @Autowired
    SmenaRepository repository;

    public List<Smena> getAllByHalaID(Integer id){
        return (List<Smena>) repository.findAll();
    }
    public List<Smena> getAll(Iterable<Integer> IDs){
        return (List<Smena>) repository.findAllById(IDs);
    }

}
