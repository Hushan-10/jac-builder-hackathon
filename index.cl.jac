import ".styles.global.css";
import from .pages.LoginPage { page as LoginPage }
import from .pages.AuthPage { page as AuthPage }
import from .pages.DashboardPage { page as DashboardPage }
import from .pages.HomePage { page as HomePage }
import from .pages.DestinationsPage { page as DestinationsPage }
import from .pages.ExperiencesPage { page as ExperiencesPage }
import from .pages.StaysPage { page as StaysPage }
import from "@jac/runtime" { Router, Routes, Route, Navigate }

def:pub ClientApp() -> JsxElement {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<HomePage />} />
                <Route path="/destinations" element={<DestinationsPage />} />
                <Route path="/experiences" element={<ExperiencesPage />} />
                <Route path="/stays" element={<StaysPage />} />
                <Route path="/login" element={<LoginPage />} />
                <Route path="/auth" element={<AuthPage />} />
                <Route path="/dashboard" element={<DashboardPage />} />
                <Route path="*" element={<Navigate to="/" replace={True} />} />
            </Routes>
        </Router>
    );
}
