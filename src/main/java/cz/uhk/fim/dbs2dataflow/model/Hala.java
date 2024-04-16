package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;


@Entity
@Table
public class Hala {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer halaID;
    
    @JoinColumn(name = "TovarnaID")
    @ManyToOne
    private Tovarna tovarna;

    private String oznaceni;

    public Integer getHalaID() {
        return halaID;
    }

    public void setHalaID(Integer halaID) {
        this.halaID = halaID;
    }

    public Tovarna getTovarna() {
        return tovarna;
    }

    public void setTovarna(Tovarna tovarna) {
        this.tovarna = tovarna;
    }

    public String getOznaceni() {
        return oznaceni;
    }

    public void setOznaceni(String oznaceni) {
        this.oznaceni = oznaceni;
    }
}
