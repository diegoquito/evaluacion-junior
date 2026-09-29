import { Routes } from '@angular/router';
import { InicioComponent } from './inicio/inicio.component';
import { ContratosComponent } from './contratos/contratos.component';

export const routes: Routes = [
  { path: '', component: InicioComponent },
  { path: 'contratos', component: ContratosComponent },
  { path: '**', redirectTo: '' }
];
