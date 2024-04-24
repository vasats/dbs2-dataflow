package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.Adresa;
import cz.uhk.fim.dbs2dataflow.model.Zamestnanec;
import cz.uhk.fim.dbs2dataflow.repository.ZamestnanecRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ZamestnanecService {
    @Autowired
    ZamestnanecRepository repository;

    public List<Zamestnanec> getAll(){
        return (List<Zamestnanec>) repository.findAll();
    }
    public void save(Zamestnanec zamestnanec){
        repository.save(zamestnanec);
    }
    public void insertZamestnanecAdresa(Adresa adresa, Zamestnanec zamestnanec){
        Zamestnanec zamestnanec1 = repository.insertZamestnanecAdresa(zamestnanec.getJmeno(), zamestnanec.getPrijmeni(), zamestnanec.getRodneCislo(),
                zamestnanec.getTelefon(), zamestnanec.getEmail(), adresa.getPsc(), adresa.getUlice(), adresa.getCisloPopisne());
    }
}
