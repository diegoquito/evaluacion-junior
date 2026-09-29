import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class ContratosService {
  private http = inject(HttpClient);
  private apiUrl = environment.apiUrl;
}
