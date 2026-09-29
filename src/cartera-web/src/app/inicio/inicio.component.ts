import { Component, inject, signal } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';

interface Salud {
  estado: string;
  clientes: number;
}

@Component({
  selector: 'app-inicio',
  standalone: true,
  templateUrl: './inicio.component.html'
})
export class InicioComponent {
  private http = inject(HttpClient);

  readonly apiUrl = environment.apiUrl;
  cargando = signal(true);
  salud = signal<Salud | null>(null);
  error = signal(false);

  constructor() {
    this.http.get<Salud>(`${this.apiUrl}/salud`).subscribe({
      next: s => { this.salud.set(s); this.cargando.set(false); },
      error: () => { this.error.set(true); this.cargando.set(false); }
    });
  }
}
