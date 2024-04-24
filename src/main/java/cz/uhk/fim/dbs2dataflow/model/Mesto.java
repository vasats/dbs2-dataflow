package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Mesto {
    @Id
    private String psc;
    private String mesto;

    public String getPsc() {
        return psc;
    }

    public void setPsc(String psc) {
        this.psc = psc;
    }

    public String getMesto() {
        return mesto;
    }

    public void setMesto(String mesto) {
        this.mesto = mesto;
    }
}
