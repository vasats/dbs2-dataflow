package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class SeznamZamestnancuID implements Serializable {
    @ManyToOne
    @JoinColumn(name = "HalaID")
    private Hala hala;

    @ManyToOne
    @JoinColumn(name = "ZamestnanecID")
    private Zamestnanec zamestnanec;

    @ManyToOne
    @JoinColumn(name = "SmenaID")
    private Smena smena;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SeznamZamestnancuID that = (SeznamZamestnancuID) o;
        return Objects.equals(hala, that.hala) && Objects.equals(zamestnanec, that.zamestnanec) && Objects.equals(smena, that.smena);
    }

    @Override
    public int hashCode() {
        return Objects.hash(hala, zamestnanec, smena);
    }
}
