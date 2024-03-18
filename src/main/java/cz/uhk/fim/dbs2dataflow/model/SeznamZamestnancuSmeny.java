package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
public class SeznamZamestnancuSmeny {
    
    @EmbeddedId
    private SeznamZamestnancuID seznamZamestnancuID;
}
