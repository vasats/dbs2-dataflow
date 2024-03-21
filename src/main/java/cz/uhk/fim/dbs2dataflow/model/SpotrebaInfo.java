package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.Entity;
import org.hibernate.annotations.Immutable;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Immutable
public class SpotrebaInfo {

    private Hala hala;
    private float spotreba;
    private Zamestnanec zamestnanec;
    private String oznaceni;
    private String nazev;
    private LocalDate datum;
    private LocalTime time;


}
