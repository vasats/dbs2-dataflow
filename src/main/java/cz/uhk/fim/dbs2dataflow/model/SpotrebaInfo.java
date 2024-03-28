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


}
