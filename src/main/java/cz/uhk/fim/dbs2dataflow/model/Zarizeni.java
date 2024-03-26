package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Zarizeni {
    @Id()
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @JoinColumn(name = "HalaID")
    @ManyToOne
    private Hala hala;
    private String oznaceni;
    private String nazev;
}
