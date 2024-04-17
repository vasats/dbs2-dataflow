package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Seznamzamestnancusmeny")
public class SeznamZamestnancuSmeny {
    
    @EmbeddedId
    private SeznamZamestnancuID seznamZamestnancuID;

    public SeznamZamestnancuID getSeznamZamestnancuID() {
        return seznamZamestnancuID;
    }

    public void setSeznamZamestnancuID(SeznamZamestnancuID seznamZamestnancuID) {
        this.seznamZamestnancuID = seznamZamestnancuID;
    }
}
