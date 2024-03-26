package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Tovarna {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @JoinColumn(name = "AdresaID")
    @OneToOne
    private Adresa adresa;
    private String foto;
    private String nazev;

}
