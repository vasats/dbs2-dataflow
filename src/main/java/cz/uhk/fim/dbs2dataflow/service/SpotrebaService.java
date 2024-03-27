package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Hala;
import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.model.ZaznamOSpotrebe;
import cz.uhk.fim.dbs2dataflow.repository.ZaznamOSpotrebeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serial;
import java.util.List;

@Service
public class SpotrebaService {
    @Autowired
    private ZaznamOSpotrebeRepository repository;

    public List<ZaznamOSpotrebe> getSpotreby(){
        return (List<ZaznamOSpotrebe>) repository.findAll();
    }
    public List<ZaznamOSpotrebe> getByHala(Hala hala){
        return repository.findAllByZarizeniHala(hala);
    }

}
