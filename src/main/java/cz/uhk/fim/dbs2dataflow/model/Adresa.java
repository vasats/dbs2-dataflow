package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
public class Adresa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AdresaID")
    private Integer id;
    private String cisloPopisne;
    private String psc;
    private String ulice;
//todo format
    @Override
    public String toString() {
        return
                psc + " " + ulice + cisloPopisne + '\'' +
                ", psc='" + psc + '\'' +
                ", ulice='" + ulice + '\'' +
                '}';
    }
}
