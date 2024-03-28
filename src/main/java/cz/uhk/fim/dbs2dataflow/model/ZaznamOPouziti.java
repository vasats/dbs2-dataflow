package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Entity
@Table
public class ZaznamOPouziti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ZaznamOPouzitiID")
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "ZamestnanecID")
    private Zamestnanec zamestnanec;

    @ManyToOne
    @JoinColumn(name = "ZarizeniID")
    private Zarizeni zarizeni;
    @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss")
    private LocalDateTime datumCas;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Zamestnanec getZamestnanec() {
        return zamestnanec;
    }

    public void setZamestnanec(Zamestnanec zamestnanec) {
        this.zamestnanec = zamestnanec;
    }

    public Zarizeni getZarizeni() {
        return zarizeni;
    }

    public void setZarizeni(Zarizeni zarizeni) {
        this.zarizeni = zarizeni;
    }

    public LocalDateTime getDatumCas() {
        return datumCas;
    }

    public void setDatumCas(LocalDateTime datumCas) {
        this.datumCas = datumCas;
    }
}
