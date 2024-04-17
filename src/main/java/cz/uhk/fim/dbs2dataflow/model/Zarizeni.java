package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
public class Zarizeni {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ZarizeniID")
    private Long id;
    
    @JoinColumn(name = "HalaID")
    @ManyToOne
    private Hala hala;
    private String oznaceni;
    private String nazev;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Hala getHala() {
        return hala;
    }

    public void setHala(Hala hala) {
        this.hala = hala;
    }

    public String getOznaceni() {
        return oznaceni;
    }

    public void setOznaceni(String oznaceni) {
        this.oznaceni = oznaceni;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }
}
