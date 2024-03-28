package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table
public class Smena {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SmenaID")
    private Integer id;
    private LocalTime casDo;
    private LocalTime casOd;
    private LocalDate datumOd;

    public LocalTime getCasDo() {
        return casDo;
    }

    public void setCasDo(LocalTime casDo) {
        this.casDo = casDo;
    }

    public LocalTime getCasOd() {
        return casOd;
    }

    public void setCasOd(LocalTime casOd) {
        this.casOd = casOd;
    }

    public LocalDate getDatumOd() {
        return datumOd;
    }

    public void setDatumOd(LocalDate datumOd) {
        this.datumOd = datumOd;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
