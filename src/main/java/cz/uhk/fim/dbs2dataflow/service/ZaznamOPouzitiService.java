package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.ZaznamOPouziti;
import cz.uhk.fim.dbs2dataflow.repository.ZaznamOPouzitiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZaznamOPouzitiService {
    @Autowired
    ZaznamOPouzitiRepository repository;
    public void saveAll(List<ZaznamOPouziti> pouziti){
        repository.saveAll(pouziti);
    }
}
