package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class ZaznamOPouziti {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ZaznamOPouzitiID")
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "ZamestnanecID")
    private Zamestnanec zamestnanec;

    @ManyToOne
    @JoinColumn(name = "ZarizeniID")
    private Zarizeni zarizeni;
}
