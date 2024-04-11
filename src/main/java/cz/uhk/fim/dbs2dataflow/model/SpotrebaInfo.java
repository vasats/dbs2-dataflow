package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;

import java.time.LocalDateTime;

@Entity
@Immutable
@Table(name = "spotrebainfo")
public class SpotrebaInfo {

    @JoinColumn(name = "HalaID")
    @ManyToOne
    private Hala hala;
    private float spotreba;
    @JoinColumn(name = "ZamestnanecID")
    @ManyToOne
    private Zamestnanec zamestnanec;
    private String oznaceni;
    private String nazev;
    @Id
    @Column(name = "datumcas")
    private LocalDateTime time;

    public Hala getHala() {
        return hala;
    }

    public void setHala(Hala hala) {
        this.hala = hala;
    }

    public float getSpotreba() {
        return spotreba;
    }

    public void setSpotreba(float spotreba) {
        this.spotreba = spotreba;
    }

    public Zamestnanec getZamestnanec() {
        return zamestnanec;
    }

    public void setZamestnanec(Zamestnanec zamestnanec) {
        this.zamestnanec = zamestnanec;
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

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }
}
