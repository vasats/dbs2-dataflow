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

    public WebovyUcet getWebovyUcet() {
        return webovyUcet;
    }

    public void setWebovyUcet(WebovyUcet webovyUcet) {
        this.webovyUcet = webovyUcet;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getJmeno() {
        return jmeno;
    }

    public void setJmeno(String jmeno) {
        this.jmeno = jmeno;
    }

    public String getPrijmeni() {
        return prijmeni;
    }

    public void setPrijmeni(String prijmeni) {
        this.prijmeni = prijmeni;
    }

    public String getRodneCislo() {
        return rodneCislo;
    }

    public void setRodneCislo(String rodneCislo) {
        this.rodneCislo = rodneCislo;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }
}
