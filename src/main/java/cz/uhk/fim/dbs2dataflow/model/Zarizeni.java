package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Table
@Entity
public class Zarizeni {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer zarizeniId;
    
    @Column(length = 30)
    private String nazev;
    
    @Column(length = 10,nullable = false)
    private String oznaceni;
    @ManyToOne
    @JoinColumn(name = "HalaID")
    private Hala hala;
    
}
