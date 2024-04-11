package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Tovarna {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "TovarnaID")
    private Integer id;
    @JoinColumn(name = "AdresaID")
    @OneToOne
    private Adresa adresa;
    private String foto;
    private String nazev;
    @Column(name = "Cenazakwh")
    private float cenaZaKwh;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Adresa getAdresa() {
        return adresa;
    }

    public void setAdresa(Adresa adresa) {
        this.adresa = adresa;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getNazev() {
        return nazev;
    }

    public void setNazev(String nazev) {
        this.nazev = nazev;
    }

    public float getCenaZaKwh() {
        return cenaZaKwh;
    }

    public void setCenaZaKwh(float cenaZaKwh) {
        this.cenaZaKwh = cenaZaKwh;
    }
}
