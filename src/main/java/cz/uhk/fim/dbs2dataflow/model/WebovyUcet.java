package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Webovyucet")
public class WebovyUcet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "WebovyucetID")
    private Integer id;

    @Column(name = "Heslohash")
    private String hesloHash;

    @Column
    private String jmeno;
    @Column
    private String typuctu;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHesloHash() {
        return hesloHash;
    }

    public void setHesloHash(String hesloHash) {
        this.hesloHash = hesloHash;
    }

    public String getJmeno() {
        return jmeno;
    }

    public void setJmeno(String jmeno) {
        this.jmeno = jmeno;
    }

    public String getTypuctu() {
        return typuctu;
    }

    public void setTypuctu(String typuctu) {
        this.typuctu = typuctu;
    }
}
