package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Zamestnanec {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ZamestnanecID")
    private Integer id;
    
    @JoinColumn(name = "AdresaID")
    @OneToOne
    private Adresa adresa;
    
    @JoinColumn(name = "WebovyUcetID")
    @OneToOne
    private WebovyUcet webovyUcet;

    private String email;
    private String jmeno;
    private String prijmeni;
    private String rodneCislo;
    private String telefon;
}
