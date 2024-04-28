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
        if(adresa.getUlice().isBlank())
            throw new IllegalArgumentException("ulice is blank");
        if(zamestnanec.getEmail().isBlank() || zamestnanec.getJmeno().isBlank()
                || zamestnanec.getPrijmeni().isBlank() || zamestnanec.getAdresa() == null)
            throw new IllegalArgumentException("zamestnanec field blank");

        String psc = adresa.getPsc();
        psc = psc.replace(" ","").trim();
        if(!psc.matches("[0-9]{5}"))
            throw new IllegalArgumentException("illegal psc");
        adresa.setPsc(psc);

        String cisloPopisne = adresa.getCisloPopisne().trim();
        if (!cisloPopisne.matches("[0-9]+|[0-9]+/[0-9]+"))
            throw new IllegalArgumentException("illegal cislo popisne");
        adresa.setCisloPopisne(cisloPopisne);

        String email = zamestnanec.getEmail().trim();
        if (!email.matches("^(.+)@(\\S+)$"))
            throw new IllegalArgumentException("illegal email");
        zamestnanec.setEmail(email);

        String rodneCislo = zamestnanec.getRodneCislo();
        rodneCislo = rodneCislo.replace("/","").trim();
        if(!rodneCislo.matches("[0-9]{10}"))
            throw new IllegalArgumentException("illegal rodne cislo");
        zamestnanec.setRodneCislo(rodneCislo);

        Zamestnanec zamestnanec1 = repository.insertZamestnanecAdresa(zamestnanec.getJmeno(), zamestnanec.getPrijmeni(), zamestnanec.getRodneCislo(),
                zamestnanec.getTelefon(), zamestnanec.getEmail(), adresa.getPsc(), adresa.getUlice(), adresa.getCisloPopisne());
    }
}
