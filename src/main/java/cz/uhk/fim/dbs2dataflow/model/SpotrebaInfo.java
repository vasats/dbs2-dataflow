package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Immutable
public class SpotrebaInfo {

    @JoinColumn
    @ManyToOne
    private Hala hala;
    private float spotreba;
    @JoinColumn
    @ManyToOne
    private Zamestnanec zamestnanec;
    private String oznaceni;
    private String nazev;
    private LocalDate datum;
    //todo make embed instead
    @Id
    private LocalTime time;

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

    public LocalDate getDatum() {
        return datum;
    }

    public void setDatum(LocalDate datum) {
        this.datum = datum;
    }

    public LocalTime getTime() {
        return time;
    }

    public void setTime(LocalTime time) {
        this.time = time;
    }
}
