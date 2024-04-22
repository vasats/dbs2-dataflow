package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Entity
@Table
public class Smena {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SmenaID")
    private Integer id;
    @Column(name = "casdo")
    private LocalDateTime casDo;
    @Column(name = "casod")
    private LocalDateTime casOd;

    public LocalDateTime getCasDo() {
        return casDo;
    }

    public void setCasDo(LocalDateTime casDo) {
        this.casDo = casDo;
    }

    public LocalDateTime getCasOd() {
        return casOd;
    }

    public void setCasOd(LocalDateTime casOd) {
        this.casOd = casOd;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
