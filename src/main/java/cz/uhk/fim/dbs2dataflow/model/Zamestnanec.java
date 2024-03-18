package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Zamestnanec {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @JoinColumn(name = "AdresaID")
    @OneToOne
    private Adresa adresa;
    
    @JoinColumn(name = "WebovyUcetID")
    @OneToOne
    private WebovyUcet webovyUcet;
}
