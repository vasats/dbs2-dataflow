package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
public class Adresa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "AdresaID")
    private Integer id;
    @Column(name = "Cislopopisne")
    private String cisloPopisne;
    private String psc;
    private String ulice;
//todo format
    @Override
    public String toString() {
        return
                psc + " " + ulice + " " + cisloPopisne;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCisloPopisne() {
        return cisloPopisne;
    }

    public void setCisloPopisne(String cisloPopisne) {
        this.cisloPopisne = cisloPopisne;
    }

    public String getPsc() {
        return psc;
    }

    public void setPsc(String psc) {
        this.psc = psc;
    }

    public String getUlice() {
        return ulice;
    }

    public void setUlice(String ulice) {
        this.ulice = ulice;
    }
}
