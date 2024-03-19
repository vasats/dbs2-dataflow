package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;

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
}
