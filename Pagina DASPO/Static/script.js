// script.js

// ========== MENÚ HAMBURGUESA ========== //
const menuToggle = document.getElementById('menu-toggle');
const navLinks = document.getElementById('nav-links');

menuToggle.addEventListener('click', () => {
  navLinks.classList.toggle('active');
});

// ========== MODO CLARO/OSCURO ========== //
const modoToggleBtn = document.getElementById('modo-toggle');

function aplicarModo(modo) {
  if (modo === 'oscuro') {
    document.body.classList.add('modo-oscuro');
    modoToggleBtn.textContent = 'Modo Claro';
  } else {
    document.body.classList.remove('modo-oscuro');
    modoToggleBtn.textContent = 'Modo Oscuro';
  }
}

function detectarModoPreferido() {
  return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'oscuro' : 'claro';
}

function cargarModo() {
  const modoGuardado = localStorage.getItem('modo') || detectarModoPreferido();
  aplicarModo(modoGuardado);
}

modoToggleBtn.addEventListener('click', () => {
  const modoActual = document.body.classList.contains('modo-oscuro') ? 'oscuro' : 'claro';
  const nuevoModo = modoActual === 'oscuro' ? 'claro' : 'oscuro';
  aplicarModo(nuevoModo);
  localStorage.setItem('modo', nuevoModo);
});

cargarModo();

// ========== FRASE MOTIVACIONAL ========== //
const frasesMotivacionales = [
  "Cada día es una nueva oportunidad para cambiar.",
  "Pequeños pasos llevan a grandes cambios.",
  "Tu fuerza está en reconocer y mejorar.",
  "No estás solo, busca ayuda cuando la necesites.",
  "El primer paso es creer en ti mismo."
];

function mostrarFrase() {
  const indice = Math.floor(Math.random() * frasesMotivacionales.length);
  const divFrase = document.getElementById('frase-motivacional');
  if (divFrase) divFrase.textContent = frasesMotivacionales[indice];
}
mostrarFrase();

// ========== CHAT ANÓNIMO BÁSICO ========== //
const chatLog = document.getElementById('chat-log');
const chatInput = document.getElementById('chat-input');

function enviarMensaje() {
  const mensaje = chatInput.value.trim();
  if (!mensaje) return;

  const nuevoMensaje = document.createElement('div');
  nuevoMensaje.classList.add('mensaje');
  nuevoMensaje.textContent = mensaje;
  chatLog.appendChild(nuevoMensaje);

  chatInput.value = '';
  chatLog.scrollTop = chatLog.scrollHeight;
}

if (chatInput) {
  chatInput.addEventListener('keypress', function (event) {
    if (event.key === 'Enter') enviarMensaje();
  });
}

// ========== LOGROS SIMULADOS ========== //
const listaLogros = document.getElementById('lista-logros');

function agregarLogro(texto) {
  if (listaLogros) {
    if (listaLogros.children.length === 1 && listaLogros.children[0].textContent.includes('No has desbloqueado')) {
      listaLogros.innerHTML = '';
    }
    const li = document.createElement('li');
    li.textContent = texto;
    listaLogros.appendChild(li);
  }
}

setTimeout(() => {
  agregarLogro("Completaste tu primer test.");
}, 2000);

// ========== QUIZ RESULTADO ========== //
const formQuiz = document.getElementById("form-quiz");

if (formQuiz) {
  formQuiz.addEventListener("submit", function (e) {
    e.preventDefault();
    const respuestas = ["q1", "q2", "q3"];
    let puntaje = 0;
    respuestas.forEach(q => {
      const val = document.querySelector(`input[name="${q}"]:checked`);
      if (val) puntaje += parseInt(val.value);
    });
    const resultado = document.getElementById("resultado-quiz");
    if (resultado) {
      if (puntaje === 0) {
        resultado.textContent = "No se detectan señales de dependencia. Sigue informado.";
      } else if (puntaje <= 2) {
        resultado.textContent = "Podrías estar desarrollando una dependencia. Reflexiona y busca apoyo si lo consideras necesario.";
      } else {
        resultado.textContent = "Alto riesgo de adicción. Es recomendable buscar ayuda profesional.";
      }
    }
  });
}
